/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
 // It is safe to enter your event code here
 } //_CODE_:button1:12356:

 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:PolyCalc:351788:
  appc.background(128);
} //_CODE_:PolyCalc:351788:

public void inputPoly1(GTextField source, GEvent event) { //_CODE_:polyText1:479189:
  try {
    s1 = polyText1.getText();

    // If polynomial a exists, and the input has changed, create a new polynomial
    if (a == null || !a.polyString.equals(s1)) {
      boolean wasGraphing = a!= null && a.graphing;

      a = new Polynomial(s1);

      // If it was graphing before, graph the updated version again
      if (wasGraphing) {
        background(255);
        a.toggleGraphing(wasGraphing);
      }
      a.printPoly();
    }
    // Catch some weird errors
  }
  catch (NullPointerException e) {
  }
  catch (StringIndexOutOfBoundsException e) {
  }

  try {
    if (a != null) {
      updatePoly1Info();
    }
  } catch (ArrayIndexOutOfBoundsException e) {}
} //_CODE_:polyText1:479189:

public void dropBox1(GDropList source, GEvent event) { //_CODE_:dropbox:816754:
  int selectedIndex = dropbox.getSelectedIndex();

  switch (selectedIndex) {
  case 1: // Add
    aAndB = a.add(b);
    aAndB.printPoly();
    answerText.setText(aAndB.toString());
    updatePoly3Info();
    break;

  case 2: // Subtract
    aAndB = a.sub(b);
    aAndB.printPoly();
    answerText.setText(aAndB.toString());
    updatePoly3Info();
    break;

  case 3: // Multiply
    aAndB = a.mult(b);
    aAndB.printPoly();
    answerText.setText(aAndB.toString());
    updatePoly3Info();
    break;

  case 4: // Graph A
    toggleNullablePolynomial(a, true);
    toggleNullablePolynomial(b, false);
    toggleNullablePolynomial(aAndB, false);
    redraw();
    break;

  case 5: // Graph B
    toggleNullablePolynomial(a, false); //disable graphing for A
    toggleNullablePolynomial(b, true); //enable graphing for B
    toggleNullablePolynomial(aAndB, false); //enable graphing for the result of A and B
    redraw();
    break;

  case 6: // Graph A and B
    toggleNullablePolynomial(a, false); //disable graphing for A
    toggleNullablePolynomial(b, false); //disable graphing for B
    toggleNullablePolynomial(aAndB, true); //enable graphing for the result of A and B
    redraw();
    break;
  }
} //_CODE_:dropbox:816754:

public void inputPoly2(GTextField source, GEvent event) { //_CODE_:polyText2:232081:
  try {
    s2 = polyText2.getText();

    println(s2);

    if (b == null || !b.polyString.equals(s2)) {
      boolean wasGraphing = b!= null && b.graphing;

      b = new Polynomial(s2);
      if (wasGraphing) {
        background(255);
        b.toggleGraphing(wasGraphing);
      }
      b.printPoly();
    }
  }
  catch (NullPointerException e) {
  }
  catch (StringIndexOutOfBoundsException e) {
  }

  try {
    if (a != null) {
      updatePoly2Info();
    }
  } catch (ArrayIndexOutOfBoundsException e) {}
} //_CODE_:polyText2:232081:

void updatePoly1Info() {
    println("Poly1Info:"); //print roots, derivates, and max/min

  if (a == null) { // Identify roots
    Poly1Info.setText("No polynomial");
  } else {
    FloatList roots = a.roots();
    String rootsString = "";

    if (roots.size() == 0) {
      rootsString = "no rational roots";
    }

    for (int i = 0; i < roots.size(); i++) { // Format roots into an array
      if (i == roots.size() - 1) {
        rootsString += Float.toString(roots.get(i));
      } else {
        rootsString += Float.toString(roots.get(i)) + ", ";
      }
    }

    aDerive = a.derive(); // Identify the derivative
    aDerive.printPoly();

    // Identify mimima/maxima
    FloatList minsMaxs = a.findMinMax();
    String minMaxString = "";

    if (minsMaxs.size() == 0) {
      minMaxString = "no mins/maxes";
    } else {
      minMaxString = "x = ";
    }

    // Format mim/max into an array
    for (int i = 0; i < minsMaxs.size(); i++) {
      if (i == minsMaxs.size() - 1) {
        minMaxString += Float.toString(minsMaxs.get(i));
      } else {
        minMaxString += Float.toString(minsMaxs.get(i)) + ", ";
      }
    }
    //output
    Poly1Info.setText("Roots: " + rootsString + "\nDerivative: " + aDerive.toString() + "\nMin/Max: " + minMaxString);
  }

  //print roots, max/min
}

public void poly1info_change1(GTextArea source, GEvent event) { //_CODE_:Poly1Info:245290:
  updatePoly1Info();
} //_CODE_:Poly1Info:245290:

void updatePoly2Info() {
    println("Poly2Info:"); //print roots, derivates, and max/min

  if (b == null) {
    Poly2Info.setText("No polynomial");
  } else {
    FloatList roots = b.roots();
    String rootsString = "";

    if (roots.size() == 0) {
      rootsString = "no rational roots";
    }

    for (int i = 0; i < roots.size(); i++) {
      if (i == roots.size() - 1) {
        rootsString += Float.toString(roots.get(i));
      } else {
        rootsString += Float.toString(roots.get(i)) + ", ";
      }
    }

    bDerive = b.derive();
    bDerive.printPoly();

    FloatList minsMaxs = b.findMinMax();
    String minMaxString = "";

    if (minsMaxs.size() == 0) {
      minMaxString = "no mins/maxes";
    } else {
      minMaxString = "x = ";
    }

    for (int i = 0; i < minsMaxs.size(); i++) {
      if (i == minsMaxs.size() - 1) {
        minMaxString += Float.toString(minsMaxs.get(i));
      } else {
        minMaxString += Float.toString(minsMaxs.get(i)) + ", ";
      }
    }
    //output
    Poly2Info.setText("Roots: " + rootsString + "\nDerivative: " + bDerive.toString() + "\nMin/Max: " + minMaxString);
  }
}

public void poly2info_change1(GTextArea source, GEvent event) { //_CODE_:Poly2Info:543126:
  updatePoly1Info();
} //_CODE_:Poly2Info:543126:

public void answer_output(GTextField source, GEvent event) { //_CODE_:answerText:599394:
  answerText.setText(aAndB.toString());
  updatePoly3Info();
} //_CODE_:answerText:599394:

void updatePoly3Info() {
    println("Poly3Info:"); //print roots, derivates, and max/min

  if (aAndB == null) {
    Poly3Info.setText("No polynomial");
  } else {
    FloatList roots = aAndB.roots();
    String rootsString = "";

    if (roots.size() == 0) {
      rootsString = "no rational roots";
    }

    for (int i = 0; i < roots.size(); i++) {
      if (i == roots.size() - 1) {
        rootsString += Float.toString(roots.get(i));
      } else {
        rootsString += Float.toString(roots.get(i)) + ", ";
      }
    }

    abDerive = aAndB.derive();
    abDerive.printPoly();

    // Identify mimima/maxima
    FloatList minsMaxs = aAndB.findMinMax();
    String minMaxString = "";

    if (minsMaxs.size() == 0) {
      minMaxString = "no mins/maxes";
    } else {
      minMaxString = "x = ";
    }

    // Format mim/max into an array
    for (int i = 0; i < minsMaxs.size(); i++) {
      if (i == minsMaxs.size() - 1) {
        minMaxString += Float.toString(minsMaxs.get(i));
      } else {
        minMaxString += Float.toString(minsMaxs.get(i)) + ", ";
      }
    }
    //output
    Poly3Info.setText("Roots: " + rootsString + "\nDerivative: " + abDerive.toString() + "\nMin/Max: " + minMaxString);
  }
}

public void poly3info_change1(GTextArea source, GEvent event) { //_CODE_:Poly3Info:534073:
  updatePoly3Info();
} //_CODE_:Poly3Info:534073:

public void min1_change1(GTextField source, GEvent event) { //_CODE_:min1:762714:
  try {
    float newMin = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMin)) {
      aGraphXmin = newMin;
      regraphNullablePolynomial(a);
    }
  } catch (NumberFormatException e) {}
} //_CODE_:min1:762714:

public void max1_change1(GTextField source, GEvent event) { //_CODE_:max1:528066:
  try {
    float newMax = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMax)) {
      aGraphXmax = newMax;
      regraphNullablePolynomial(a);
    }
  } catch (NumberFormatException e) {}
} //_CODE_:max1:528066:

public void min2_change1(GTextField source, GEvent event) { //_CODE_:min2:804767:
  try {
    float newMin = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMin)) {
      bGraphXmin = newMin;
      regraphNullablePolynomial(b);
    }
  } catch (NumberFormatException e) {}
} //_CODE_:min2:804767:

public void max2_change1(GTextField source, GEvent event) { //_CODE_:max2:669949:
  try {
    float newMax = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMax)) {
      bGraphXmax = newMax;
      regraphNullablePolynomial(b);
    }
  } catch (NumberFormatException e) {}
} //_CODE_:max2:669949:

public void min3_change1(GTextField source, GEvent event) {
  try {
    float newMin = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMin)) {
      aAndBGraphXmin = newMin;
      regraphNullablePolynomial(aAndB);
    }
  } catch (NumberFormatException e) {}
}

public void max3_change1(GTextField source, GEvent event) {
  try {
    float newMax = Float.parseFloat(source.getText());

    if (!Float.isNaN(newMax)) {
      aAndBGraphXmax = newMax;
      regraphNullablePolynomial(aAndB);
    }
  } catch (NumberFormatException e) {}
}



  // Create all the GUI controls.
  // autogenerated do not edit
  public void createGUI() {
    G4P.messagesEnabled(false);
    G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
    G4P.setMouseOverEnabled(false);
    surface.setTitle("Sketch Window");
    PolyCalc = GWindow.getWindow(this, "PolyCalc2", 0, 0, 550, 500, JAVA2D);
    PolyCalc.noLoop();
    PolyCalc.setActionOnClose(G4P.KEEP_OPEN);
    PolyCalc.addDrawHandler(this, "win_draw1");
    title = new GLabel(PolyCalc, 208, 22, 108, 28);
    title.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    title.setText("PolyCalc 2.0");
    title.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    title.setOpaque(true);
    polyText1 = new GTextField(PolyCalc, 23, 93, 183, 30, G4P.SCROLLBARS_NONE);
    polyText1.setLocalColorScheme(GCScheme.RED_SCHEME);
    polyText1.setOpaque(true);
    polyText1.addEventHandler(this, "inputPoly1");
    polytext1 = new GLabel(PolyCalc, 23, 64, 164, 20);
    polytext1.setText("Enter Your 1st Polynomial");
    polytext1.setLocalColorScheme(GCScheme.RED_SCHEME);
    polytext1.setOpaque(true);
    dropbox = new GDropList(PolyCalc, 220, 95, 91, 161, 6, 10);
    dropbox.setItems(loadStrings("list_816754"), 0);
    dropbox.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    dropbox.addEventHandler(this, "dropBox1");
    label1 = new GLabel(PolyCalc, 325, 64, 164, 20);
    label1.setText("Enter Your 2nd Polynomial");
    label1.setLocalColorScheme(GCScheme.RED_SCHEME);
    label1.setOpaque(true);
    polyText2 = new GTextField(PolyCalc, 324, 93, 183, 31, G4P.SCROLLBARS_NONE);
    polyText2.setLocalColorScheme(GCScheme.RED_SCHEME);
    polyText2.setOpaque(false);
    polyText2.addEventHandler(this, "inputPoly2");
    Poly1Info = new GTextArea(PolyCalc, 23, 160, 105, 105, G4P.SCROLLBARS_NONE);
    Poly1Info.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    Poly1Info.setOpaque(true);
    Poly1Info.addEventHandler(this, "poly1info_change1");
    Poly2Info = new GTextArea(PolyCalc, 324, 160, 105, 105, G4P.SCROLLBARS_NONE);
    Poly2Info.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    Poly2Info.setOpaque(true);
    Poly2Info.addEventHandler(this, "poly2info_change1");
    label2 = new GLabel(PolyCalc, 24, 135, 105, 20);
    label2.setText("Polynomial Info:");
    label2.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    label2.setOpaque(true);
    label3 = new GLabel(PolyCalc, 325, 135, 105, 20);
    label3.setText("Polynomial Info:");
    label3.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    label3.setOpaque(true);
    label4 = new GLabel(PolyCalc, 35, 271, 456, 19);
    label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    label4.setText("__________________________________________________________________");
    label4.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    label4.setOpaque(true);
    label5 = new GLabel(PolyCalc, 44, 309, 80, 20);
    label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    label5.setText("Answer:");
    label5.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    label5.setOpaque(true);
    answerText = new GTextField(PolyCalc, 142, 303, 322, 35, G4P.SCROLLBARS_NONE);
    answerText.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    answerText.setOpaque(true);
    answerText.addEventHandler(this, "answer_output");
    label6 = new GLabel(PolyCalc, 141, 349, 109, 21);
    label6.setText("Polynomial Info:");
    label6.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    label6.setOpaque(true);
    Poly3Info = new GTextArea(PolyCalc, 141, 379, 208, 84, G4P.SCROLLBARS_NONE);
    Poly3Info.setLocalColorScheme(GCScheme.CYAN_SCHEME);
    Poly3Info.setOpaque(true);
    Poly3Info.addEventHandler(this, "poly3info_change1");
    min1 = new GTextField(PolyCalc, 139, 161, 69, 26, G4P.SCROLLBARS_NONE);
    min1.setOpaque(true);
    min1.addEventHandler(this, "min1_change1");
    poly1min = new GLabel(PolyCalc, 138, 133, 68, 22);
    poly1min.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly1min.setText("xMin");
    poly1min.setOpaque(false);
    poly1max = new GLabel(PolyCalc, 139, 195, 68, 21);
    poly1max.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly1max.setText("xMax");
    poly1max.setOpaque(false);
    max1 = new GTextField(PolyCalc, 139, 223, 68, 27, G4P.SCROLLBARS_NONE);
    max1.setOpaque(true);
    max1.addEventHandler(this, "max1_change1");
    poly2min = new GLabel(PolyCalc, 441, 134, 64, 20);
    poly2min.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly2min.setText("xMin");
    poly2min.setOpaque(false);
    min2 = new GTextField(PolyCalc, 441, 163, 65, 24, G4P.SCROLLBARS_NONE);
    min2.setOpaque(true);
    min2.addEventHandler(this, "min2_change1");
    poly2max = new GLabel(PolyCalc, 441, 195, 65, 20);
    poly2max.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly2max.setText("xMax");
    poly2max.setOpaque(false);
    max2 = new GTextField(PolyCalc, 441, 223, 67, 24, G4P.SCROLLBARS_NONE);
    max2.setOpaque(true);
    max2.addEventHandler(this, "max2_change1");
    poly3min = new GLabel(PolyCalc, 375, 365, 64, 20);
    poly3min.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly3min.setText("xMin");
    poly3min.setOpaque(false);
    min3 = new GTextField(PolyCalc, 375, 390, 65, 24, G4P.SCROLLBARS_NONE);
    min3.setOpaque(true);
    min3.addEventHandler(this, "min3_change1");
    poly3max = new GLabel(PolyCalc, 375, 415, 65, 20);
    poly3max.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    poly3max.setText("xMax");
    poly3max.setOpaque(false);
    max3 = new GTextField(PolyCalc, 375, 440, 67, 24, G4P.SCROLLBARS_NONE);
    max3.setOpaque(true);
    max3.addEventHandler(this, "max3_change1");
    PolyCalc.loop();
    PolyCalc.loop();
  }

// Variable declarations
// autogenerated do not edit
GWindow PolyCalc;
GLabel title;
GTextField polyText1;
GLabel polytext1;
GDropList dropbox;
GLabel label1;
GTextField polyText2;
GTextArea Poly1Info;
GTextArea Poly2Info;
GLabel label2;
GLabel label3;
GLabel label4;
GLabel label5;
GTextField answerText;
GLabel label6;
GTextArea Poly3Info;
GTextField min1;
GLabel poly1min;
GLabel poly1max;
GTextField max1;
GLabel poly2min;
GTextField min2;
GLabel poly2max;
GTextField max2;
GLabel poly3min;
GTextField min3;
GLabel poly3max;
GTextField max3;
