class Vertex {
    private PVector v;
    private ArrayList<Edge> edges = new ArrayList<>();
    private ArrayList<Surface> surfaces = new ArrayList<>();

    private PVector vertexPoint;

    public Vertex(float x, float y, float z) {
        this(new PVector(x, y, z));
    }

    public Vertex(PVector v) {
        this.v = v;
    }

    public float getX() {
        return v.x;
    }

    public float getY() {
        return v.y;
    }

    public float getZ() {
        return v.z;
    }

    public Vertex addEdge(Edge e) {
        if (!edges.contains(e))
            edges.add(e);

        return this;
    }

    public Vertex addSurface(Surface s) {
        if (!surfaces.contains(s))
            surfaces.add(s);

        return this;
    }

    public PVector getVertexPoint() {
        if (vertexPoint == null) {
            int n = surfaces.size();

            float x = 0;
            float y = 0;
            float z = 0;

            for (Surface s : surfaces) {
                PVector fPoint = s.getSurfacePoint();

                x += fPoint.x;
                y += fPoint.y;
                z += fPoint.z;
            }

            for (Edge e : edges) {
                PVector ePoint = e.getEdgeMidpoint();

                x += 2 * ePoint.x;
                y += 2 * ePoint.y;
                z += 2 * ePoint.z;
            }

            x += (n - 3) * v.x;
            y += (n - 3) * v.y;
            z += (n - 3) * v.z;

            x /= n;
            y /= n;
            z /= n;

            vertexPoint = new PVector(x, y, z);
        }
        return vertexPoint;
    }

    public String toString() {
        return v.toString();
    }

    public PVector toPVector() {
        return v;
    }
}