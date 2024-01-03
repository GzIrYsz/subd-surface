class Surface {
    private ArrayList<Edge> edges = new ArrayList<>();
    private ArrayList<PVector> vertices = new ArrayList<>();

    private PVector surfacePoint;

    public Surface() {

    }

    public ArrayList<Edge> getEdges() {
        return edges;
    }

    public Surface setEdges(ArrayList<Edge> edges) {
        this.edges = edges;
        return this;
    }

    public Edge getEdge(int i) {
    }

    public Surface setEdge(int i, Edge e) {
        edges.set(i, e);
        return this;
    }

    public Surface addEdge(Edge e) {
        if (!edges.contains(e)) {
            edges.add(e);

            if (!vertices.contains(e.getA()))
                vertices.add(e.getA().toPVector());

            if (!vertices.contains(e.getB()))
                vertices.add(e.getB().toPVector());
        }
        e.addNeighbouringFace(this);
        return this;
    }

    public Surface draw() {
        beginShape(QUADS);
        for (PVector v : vertices) {
            vertex(v.x, v.y, v.z);
        }
        endShape();
        return this;
    }

    public PVector getSurfacePoint() {
        if (surfacePoint == null) {
            float x = 0;
            float y = 0;
            float z = 0;
            for (PVector vertex : vertices) {
                x += vertex.x;
                y += vertex.y;
                z += vertex.z;
            }
            x /= vertices.size();
            y /= vertices.size();
            z /= vertices.size();

            surfacePoint = new PVector(x, y, z);
        }
        return surfacePoint;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;

        if (o == null || getClass() != o.getClass()) return false;

        Surface s = (Surface) o;
        return this.edges.equals(s.getEdges());
    }

    @Override
    public String toString() {
        StringBuilder out = new StringBuilder("Surface{\n");
        for (Edge edge : edges) {
            out.append("\t");
            out.append(edge.toString());
            out.append("\n");
        }
        out.append("}");
        return out.toString();
    }
}