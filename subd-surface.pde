import controlP5.*;

ControlP5 cp5;
float angle = 0;
boolean keys[] = new boolean[255];
Shape s;

void setup() {
    size(800, 800, P3D);
    surface.setResizable(true);
    cp5 = new ControlP5(this);
    s = createCube(200);
    s.subdivide();
}

void draw() {
    lights();
    background(0);
    //noStroke();
    stroke(255);
    noFill();
    //fill(255);
    float size = 100;

    pushMatrix();

    translate(width/2, height/2, 0);

    rotateX(angle);
    rotateY(angle);
    rotateZ(angle * 0.1);

    s.draw();
    /*if (keys[(int) 'T']) {
        System.out.println(s);
        //drawFacePoints(createShape(), size*0.03);
    }*/
    if (keys[(int) 'E']) {
        s.drawSubdivisionPoints(6);
    }
    /*if(keys[(int) 'V']) {
        drawVertexPoint(createShape(), size*0.03);
    }*/
    if (!keys[(int) 'P']) {
        angle += 0.01;
    }

    popMatrix();
}

Shape createCube(float size) {
    Shape s = new Shape();

    Vertex v1 = new Vertex(0, 0, 0);
    Vertex v2 = new Vertex(0, size, 0);
    Vertex v3 = new Vertex(size, size, 0);
    Vertex v4 = new Vertex(size, 0, 0);
    Vertex v5 = new Vertex(0, 0, -size);
    Vertex v6 = new Vertex(0, size, -size);
    Vertex v7 = new Vertex(size, size, -size);
    Vertex v8 = new Vertex(size, 0, -size);

    Edge e1 = new Edge(v1, v2);
    Edge e2 = new Edge(v2, v3);
    Edge e3 = new Edge(v3, v4);
    Edge e4 = new Edge(v4, v1);
    Edge e5 = new Edge(v5, v6);
    Edge e6 = new Edge(v6, v7);
    Edge e7 = new Edge(v7, v8);
    Edge e8 = new Edge(v8, v5);
    Edge e9 = new Edge(v1, v5);
    Edge e10 = new Edge(v8, v4);
    Edge e11 = new Edge(v2, v6);
    Edge e12 = new Edge(v7, v3);

    s.addSurface(new Surface()
        .addEdge(e1)
        .addEdge(e2)
        .addEdge(e3)
        .addEdge(e4));

    s.addSurface(new Surface()
        .addEdge(e5)
        .addEdge(e6)
        .addEdge(e7)
        .addEdge(e8));

    s.addSurface(new Surface()
        .addEdge(e9)
        .addEdge(e8)
        .addEdge(e10)
        .addEdge(e4));

    s.addSurface(new Surface()
        .addEdge(e11)
        .addEdge(e6)
        .addEdge(e12)
        .addEdge(e2));

    s.addSurface(new Surface()
        .addEdge(e9)
        .addEdge(e5)
        .addEdge(e11)
        .addEdge(e1));

    s.addSurface(new Surface()
        .addEdge(e10)
        .addEdge(e7)
        .addEdge(e12)
        .addEdge(e3));
    return s;
}

/*void drawFacePoints(Shape s, float sphereRadius) {
    noStroke();
    fill(#00FFFF);
    for (int i = 0; i < s.getVertexCount(); i += 4) {
        float avgX = 0;
        float avgY = 0;
        float avgZ = 0;
        for (int j = i; j < i + 4; j++) {
            PVector currentV = s.getVertex(j);
            avgX += currentV.x;
            avgY += currentV.y;
            avgZ += currentV.z;
        }
        avgX /= 4;
        avgY /= 4;
        avgZ /= 4;
        pushMatrix();
        translate(avgX, avgY, avgZ);
        sphere(sphereRadius);
        popMatrix();
    }
}*/

/*void drawEdgePoints(PShape s, float sphereRadius) {
    noStroke();
    fill(#FF00FF);
    for (int i = 0; i < s.getVertexCount(); i++) {
        Edge e;
        ArrayList<PVector[]> neighbouringFaces = new ArrayList<>();
        if ((i+1) % 4 == 0 && i != 0) {
            e = new Edge(s.getVertex(i), s.getVertex(i-3));
        } else {
            e = new Edge(s.getVertex(i), s.getVertex(i+1));
        }
        //System.out.println("\nNb of vertex (s): " + s.getVertexCount());
        //System.out.println(e);
        for (int j = 0; j < s.getVertexCount(); j += 4) {
            PVector v0 = s.getVertex(j);
            PVector v1 = s.getVertex(j+1);
            PVector v2 = s.getVertex(j+2);
            PVector v3 = s.getVertex(j+3);
            //System.out.println("\nv0: " + v0);
            //System.out.println("v1: " + v1);
            //System.out.println("v2: " + v2);
            //System.out.println("v3: " + v3);
            if (e.equals(new Edge(v0, v1)) || e.equals(new Edge(v1, v2)) || e.equals(new Edge(v2, v3)) || e.equals(new Edge(v3, v0))) {
                PVector face[] = { v0, v1, v2, v3 };
                neighbouringFaces.add(face);
                //System.out.println("Face added\n");
            }
        }

        PVector fP1 = new PVector(0, 0, 0);
        PVector fP2 = new PVector(0, 0, 0);
        for (int j = 0; j < 4; j++) {
            fP1.x += neighbouringFaces.get(0)[j].x;
            fP1.y += neighbouringFaces.get(0)[j].y;
            fP1.z += neighbouringFaces.get(0)[j].z;

            fP2.x += neighbouringFaces.get(1)[j].x;
            fP2.y += neighbouringFaces.get(1)[j].y;
            fP2.z += neighbouringFaces.get(1)[j].z;
        }
        fP1.x /= 4;
        fP1.y /= 4;
        fP1.z /= 4;

        fP2.x /= 4;
        fP2.y /= 4;
        fP2.z /= 4;

        float avgX = (fP1.x + fP2.x + e.getA().x + e.getB().x) / 4;
        float avgY = (fP1.y + fP2.y + e.getA().y + e.getB().y) / 4;
        float avgZ = (fP1.z + fP2.z + e.getA().z + e.getB().z) / 4;

        pushMatrix();
        translate(avgX, avgY, avgZ);
        sphere(sphereRadius);
        popMatrix();
    }
}

void drawVertexPoint(PShape s, float sphereRadius) {
    noStroke();
    fill(#FFFF00);
    for (int i = 0; i < s.getVertexCount(); i++) {
        ArrayList<Edge> edges = new ArrayList<>();
    }
}*/

void keyPressed() {
    keys[keyCode] = !keys[keyCode];
}