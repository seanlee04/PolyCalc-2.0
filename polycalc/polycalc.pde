import java.util.Arrays;
import g4p_controls.*;

float xMin, xMax, yMin, yMax;
float aGraphXmin = -5, aGraphXmax = 5, bGraphXmin = -5, bGraphXmax = 5, aAndBGraphXmin = -5, aAndBGraphXmax = 5;
float xRange, yRange;
float unitsPerPixel; //the ratio (aMax-aMin)/width;

//String s1 = "1x^2+1x+0";
//String s2 = "2x^2+1x+7";
String s1, s2;

int[][] poly;
int tStart, tEnd, p, n;
String polyPrint = "";
String roots = "";
String minMax = "";
int selected = 0;

Polynomial a, b;
Polynomial aAndB, aDerive, bDerive, abDerive;

int[][] copy2dArray(int[][] array) {
    int[][] clone = new int[array.length][array[0].length];

    for (int i = 0; i < array.length; i++) {
        arrayCopy(array[i], 0, clone[i], 0, array[i].length);
        // for (int j = 0; j < array[i].length; j++) {
        //     clone[i][j] = array[i][j];
        // }
    }

    return clone;
}

void setup() {
  createGUI();
  size(800,800);
  background(255);
  frameRate(30);

  xMin = -1.8;
  xMax = 0.5;
  yMin = -1.15;
  yMax = 1.15;

  unitsPerPixel = (xMax-xMin)/width;

  xRange = xMax - xMin;
  yRange = yMax - yMin;

  //a = new Polynomial(s1);
  //b = new Polynomial(s2);

  //a.printPoly();
  //b.printPoly();

  //aAndB = a.add(b);
  //aAndB.printPoly();

  //a.add(b).printPoly();
  //a.sub(b).printPoly();
  //a.mult(b).printPoly();
}

public static int[][] deepCopyIntArray(int[][] original) {
  if (original == null) {
    return null;
  }

  final int[][] result = new int[original.length][];
  for (int i = 0; i < original.length; i++) {
    result[i] = Arrays.copyOf(original[i], original[i].length);
  }
  return result;
}

/**
 * Toggles graphing on a possibly null polynomial
 */
void toggleNullablePolynomial(Polynomial poly, boolean value) {
  if (poly != null) {
    poly.toggleGraphing(value);
  }
}

/**
 * Forces regraph on the next frame on a possibly null polynomial
 */
void regraphNullablePolynomial(Polynomial poly) {
  if (poly != null) {
    poly.didGraph = false;
  }
}

void draw() {
  strokeWeight(2);

  // Check if the given polynomial exists, and if it has graphing enabled
  if (a != null && a.graphing) {
    // If not already graphed, clear canvas and graph
    if (!a.didGraph) {
      background(255);
      a.graph(aGraphXmin, aGraphXmax);
    }
  } else if (b != null && b.graphing) {
    if (!b.didGraph) {
      background(255);
      b.graph(bGraphXmin, bGraphXmax);
    }
  } else if (aAndB != null && aAndB.graphing) {
    if (!aAndB.didGraph) {
      background(255);
      aAndB.graph(aAndBGraphXmin, aAndBGraphXmax);
    }
  } else {
    background(255);
  }
}
