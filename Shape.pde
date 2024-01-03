class Shape {
    private ArrayList<Surface> surfaces = new ArrayList<>();
    private ArrayList<Shape> subdivisions = new ArrayList<>();

    private ArrayList<PVector> facePoints = new ArrayList<>();
    private ArrayList<PVector> edgePoints = new ArrayList<>();
    private ArrayList<PVector> vertexPoint = new ArrayList<>();


    public Shape() {

    }

    public ArrayList<Surface> getSurfaces() {
        return surfaces;
    }

    public Shape setSurfaces(ArrayList<Surface> surfaces) {
        this.surfaces = surfaces;
        return this;
    }

    public Surface getSurface(int i) {
        return surfaces.get(i);
    }

    public Shape setSurface(int i, Surface surface) {
        surfaces.set(i, surface);
        return this;
    }

    public Shape addSurface(Surface surface) {
        surfaces.add(surface);
        return this;
    }

    public Shape subdivide() {
        noStroke();
        fill(#00FFFF);
        for (Surface s : surfaces) {
            PVector facePoint = s.getSurfacePoint();
            facePoints.add(facePoint);

            for (Edge e : s.getEdges()) {
                PVector edgePoint = e.getEdgePoint();
                edgePoints.add(edgePoint);

                Vertex a = e.getA();
                Vertex b = e.getB();

                PVector v1Point = a.getVertexPoint();
                PVector v2Point = a.getVertexPoint();

                vertexPoint.add(v1Point);
                vertexPoint.add(v2Point);
            }
        }
        return this;
    }

    public Shape draw() {
        if (!subdivisions.isEmpty()) {
            subdivisions.get(subdivisions.size() - 1).draw();
        } else {
            for (Surface s : surfaces) {
                s.draw();
            }
        }
        return this;
    }

    public Shape drawSubdivisionPoints(float sphereRadius) {
        noStroke();

        fill(#00FFFF);
        for (PVector v : facePoints) {
            pushMatrix();
            translate(v.x, v.y, v.z);
            sphere(sphereRadius);
            popMatrix();
        }

        fill(#FF00FF);
        for (PVector v : edgePoints) {
            pushMatrix();
            translate(v.x, v.y, v.z);
            sphere(sphereRadius);
            popMatrix();
        }

        fill(#FFFF00);
        for (PVector v : vertexPoint) {
            pushMatrix();
            translate(v.x, v.y, v.z);
            sphere(sphereRadius);
            popMatrix();
        }

        return this;
    }

    @Override
    public String toString() {
        StringBuilder out = new StringBuilder("Shape{\n");
        for (Surface surface : surfaces) {
            out.append("\t");
            out.append(surface.toString());
            out.append("\n");
        }
        out.append("}");
        return out.toString();
    }
}