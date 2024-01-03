class Edge {
    private Vertex a, b;
    private ArrayList<Surface> neighbouringFaces = new ArrayList<>();

    private PVector edgePoint, edgeMidpoint;

    public Edge(Vertex a, Vertex b) {
        setA(a);
        setB(b);
    }

    public Vertex getA() {
        return a;
    }

    public Vertex getB() {
        return b;
    }

    public Edge setA(Vertex a) {
        this.a = a;
        return this;
    }

    public Edge setB(Vertex b) {
        this.b = b;
        return this;
    }

    public ArrayList<Surface> getNeighbouringFaces() {
        return neighbouringFaces;
    }

    public Surface getNeighbouringFace(int i) {
        return neighbouringFaces.get(i);
    }

    public Edge addNeighbouringFace(Surface s) {
        if (!neighbouringFaces.contains(s))
            neighbouringFaces.add(s);

        a.addSurface(s);
        b.addSurface(s);

        return this;
    }

    public PVector getEdgePoint() {
        if (edgePoint == null) {
            PVector fPoint1 = neighbouringFaces.get(0).getSurfacePoint();
            PVector fPoint2 = neighbouringFaces.get(1).getSurfacePoint();

            float x = (fPoint1.x + fPoint2.x + a.getX() + b.getX()) / 4;
            float y = (fPoint1.y + fPoint2.y + a.getY() + b.getY()) / 4;
            float z = (fPoint1.z + fPoint2.z + a.getZ() + b.getZ()) / 4;

            edgePoint = new PVector(x, y, z);
        }
        return edgePoint;
    }

    public PVector getEdgeMidpoint() {
        if (edgeMidpoint == null) {
            float x = (a.getX() + b.getX()) / 2;
            float y = (a.getY() + b.getY()) / 2;
            float z = (a.getZ() + b.getZ()) / 2;

            edgeMidpoint = new PVector(x, y, z);
        }
        return edgeMidpoint;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;

        if (o == null || getClass() != o.getClass()) return false;

        Edge e = (Edge) o;
        float eAX = e.getA().getX();
        float eAY = e.getA().getY();
        float eAZ = e.getA().getZ();

        float eBX = e.getB().getX();
        float eBY = e.getB().getY();
        float eBZ = e.getB().getZ();

        return (a.getX() == eAX || a.getX() == eBX) && (b.getX() == eBX || b.getX() == eAX) &&
            (a.getY() == eAY || a.getY() == eBY) && (b.getY() == eBY || b.getY() == eAY) &&
            (a.getZ() == eAZ || a.getZ() == eBZ) && (b.getZ() == eBZ || b.getZ() == eAZ);
    }

    @Override
    public String toString() {
        return "Edge{" +
            "a=" + a.toString() +
            ", b=" + b.toString() +
            '}';
    }
}