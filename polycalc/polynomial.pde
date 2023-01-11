class Polynomial {
  String polyString;
  int[][] polyArray;
  boolean graphing = false; // If graphing is enabled
  boolean didGraph = false; // If the graph was displayed

  Polynomial(String s) {
    this.polyString = s;
    int count = 1; //There is always one term in a polynomial

    for (int i = 0; i < this.polyString.length(); i++) { //Determines the array based on the number of additional terms besides the first term
      try {
        if (this.polyString.substring(i, i+1).equals("+") || this.polyString.substring(i, i+1).equals("-") && !this.polyString.substring(i-1, i).equals("^")) //Looks for addition and subtraction signs and makes sure that the sign isn't for the exponent value
          count ++;
      }
      catch(StringIndexOutOfBoundsException e) {
      }
    }

    this.polyArray = new int[count][2];
    this.createArray();
  }

  Polynomial(int[][] p) {
    this.polyArray = p;
  }

  void createArray() {
    tStart = 0; //Index of the first term
    if (this.polyArray.length == 1) { //Checks if polynomial has only one term
      if (this.polyString.indexOf("x") == -1) { //Checks if term has x
        this.polyArray[0][0] = int(this.polyString.substring(0));
        this.polyArray[0][1] = 0;
      } else {
        if (this.polyString.substring(0, 1).equals("-") && this.polyString.substring(1, 2).equals("x")) //Checks if the coefficient -1
          this.polyArray[0][0] = -1;
        else if (this.polyString.indexOf("x") == 0) //Checks if there is no coefficient written before x which means the coefficient is 1
          this.polyArray[0][0] = 1;
        else
          this.polyArray[0][0] = int(this.polyString.substring(0, this.polyString.indexOf("x")));

        if (this.polyString.indexOf("^") == -1) { //Checks if there isn't exponent on x
          this.polyArray[0][1] = 1;
        } else {
          this.polyArray[0][1] = int(this.polyString.substring(this.polyString.indexOf("^")+1));
        }
      }
    } else {
      for (int i = 0; i < this.polyArray.length; i++) {
        boolean exp;
        p = this.polyString.indexOf("+", tStart+1); //Index of closest + sign
        n = this.polyString.indexOf("-", tStart+1); //Index of closest - sign
        if (n == 0) {
          n = this.polyString.indexOf("-", 1);
        }
        if (n > 0) {
          if (this.polyString.substring(n-1, n).equals("^")) { //Checks if - sign is after ^ which means the - is for the exponent
            n = this.polyString.indexOf("-", n+1);
          }
        }
        if (p < 0 && n < 0) { //If no more term
          tEnd = this.polyString.length();
        } else if (p < 0 && n > 0) { //if no more additon but still subtraction
          tEnd = n;
        } else if (n < 0 && p > 0) { //if no more subtraction but still addition
          tEnd = p;
        } else if (p < n) { //Comapres the closest addition term and subtraction term and determines the index that is smaller determines whether addition or subtraction is happening next
          tEnd = p;
        } else {
          tEnd = n;
        }
        if (tStart == this.polyString.indexOf("x", tStart)) { //Checks if there is no written coefficient before x
          exp = true;
          this.polyArray[i][0] = 1;
        } else if (this.polyString.substring(tStart+1, tStart+2).equals("x")) { //Checks if first character is x
          exp = true;
          if (this.polyString.substring(tStart, tStart + 1).equals("+"))  //Checks if arthimetic is addition or subtraction
            this.polyArray[i][0] = 1;
          else if (this.polyString.substring(tStart, tStart + 1).equals("-")) //Checks if arthimetic is addition or subtraction
            this.polyArray[i][0] = -1;
          else //If coefficient of the first term is only 1 digit
            this.polyArray[i][0] = int(this.polyString.substring(0, 1));
        } else if (this.polyString.indexOf("x", tStart) < tEnd && this.polyString.indexOf("x", tStart) != -1) { //Checks if term contains x
          exp = true;
          this.polyArray[i][0] = int(this.polyString.substring(tStart, this.polyString.indexOf("x", tStart)));
        } else { //Term is coefficient
          exp = false;
          this.polyArray[i][0] = int(this.polyString.substring(tStart, tEnd));
          this.polyArray[i][1] = 0;
        }

        if (exp) {
          try {
            if (this.polyString.substring(this.polyString.indexOf("x", tStart)+1, this.polyString.indexOf("x", tStart) + 2).equals("^")) { //Checks if after x is ^ which means there is an exponent
              this.polyArray[i][1] = int(this.polyString.substring(this.polyString.indexOf("x", tStart) + 2, tEnd));
            } else { //Since no ^, exponent must be 1
              this.polyArray[i][1] = 1;
            }
          }
          catch(StringIndexOutOfBoundsException e) {
            this.polyArray[i][1] = 1;
          }
        }
        tStart = tEnd; //Resets so that the next term of the polynomial is being put in the array
      }
    }
  }

    String toString(boolean includeSpaces) {
    String polyPrint = "";

    for (int j = 0; j < this.polyArray.length; j++) {
      if (j != 0) { //Checks if term being printed isn't the first term
        if (this.polyArray[j][0] == 1) //If coefficent is 1 then only the + sign has to be printed
          polyPrint += " + ";
        else if (this.polyArray[j][0] == -1) //If coefficent is -1 then only the - sign has to be printed
          polyPrint += " - ";
        else if (this.polyArray[j][0] > 0) //If coefficent is positive, print the + sign and the coefficent of the term
          polyPrint += (" + " + str(this.polyArray[j][0]));
        else if (this.polyArray[j][0] < 0) //If coefficent is negative, print the - sign and the coefficent of the term
          polyPrint += (" - " + str(this.polyArray[j][0]*-1));
      } else { //Printing the first term
        if (this.polyArray[j][0] == 1) //If coefficient is 1, print nothing
          polyPrint += "";
        else if (this.polyArray[j][0] == -1) //If coefficient is -1, print - sign
          polyPrint += "-";
        else if (this.polyArray[j][0] != 0) //Checks if coeffienct isn't 0
          polyPrint += str(this.polyArray[j][0]);
      }
      if (j == this.polyArray.length-1 && (this.polyArray[j][0] == 1 || this.polyArray[j][0] == -1) && this.polyArray[j][1] == 0) //Checks if it's printing the last term and is 1
        polyPrint += "1";

      if (this.polyArray[j][1] == 0) //Prints nothing if coefficient is 0
        polyPrint += "";
      else if (this.polyArray[j][1] == 1) //Only prints x is coefficient is 1
        polyPrint += "x";
      else
        polyPrint += ("x^" + str(this.polyArray[j][1]));
    }

    return polyPrint;
  }

  String toString() {
    return this.toString(true);
  }

  void printPoly() {
    println();
    println("polyPrint", this);
  }

  Polynomial add(Polynomial other) {
    IntList exp = new IntList();
    for (int i = 0; i < this.polyArray.length; i++) {
      if (!exp.hasValue(this.polyArray[i][1])) //Checks for distinct exponent
        exp.append(this.polyArray[i][1]);
    }
    for (int i = 0; i < other.polyArray.length; i++) {
      if (!exp.hasValue(other.polyArray[i][1])) //Checks for distinct exponent
        exp.append(other.polyArray[i][1]);
    }
    exp.sortReverse(); //Orders the exponents from greatest to smallest
    if (exp.hasValue(0)) { //Moves coefficent term to end
      for (int i = 0; i < exp.size(); i++) {
        if (exp.get(i) == 0) {
          exp.remove(i);
          exp.append(0);
          break;
        }
      }
    }
    int[][] a = new int[exp.size()][2]; //Creates new array with all the unique exponents
    for (int i = 0; i < a.length; i++) {
      a[i][1] = exp.get(i);
    }
    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < this.polyArray.length; j++) {
        if (this.polyArray[j][1] == a[i][1]) //Checks if exponent in polynomial a is the same as exponent
          a[i][0] += this.polyArray[j][0];
      }
      for (int j = 0; j < other.polyArray.length; j++) {
        if (other.polyArray[j][1] == a[i][1]) //Checks if exponent in polynomial b is the same as exponent
          a[i][0] += other.polyArray[j][0];
      }
    }

    int count = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i][0] != 0) //Counts the number of terms in new array that don't have coefficient of 0
        count++;
    }

    int[][] b = new int[count][2]; //Creates another nre array that will contain final polynomial
    int j = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i][0] != 0) { //Checks if coefficent isn't 0
        b[j][0] = a[i][0];
        b[j][1] = a[i][1];
        j++;
      }
    }

    return(new Polynomial(b));
  }

  Polynomial sub(Polynomial other) {
    IntList exp = new IntList();
    for (int i = 0; i < this.polyArray.length; i++) {
      if (!exp.hasValue(this.polyArray[i][1])) //Checks for distinct exponent
        exp.append(this.polyArray[i][1]);
    }
    for (int i = 0; i < other.polyArray.length; i++) {
      if (!exp.hasValue(other.polyArray[i][1])) //Checks for distinct exponent
        exp.append(other.polyArray[i][1]);
    }
    exp.sortReverse(); //Orders the exponents from greatest to smallest
    if (exp.hasValue(0)) { //Moves coefficent term to end
      for (int i = 0; i < exp.size(); i++) {
        if (exp.get(i) == 0) {
          exp.remove(i);
          exp.append(0);
          break;
        }
      }
    }
    int[][] a = new int[exp.size()][2]; //Creates new array with all the unique exponents
    for (int i = 0; i < a.length; i++) {
      a[i][1] = exp.get(i);
    }
    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < this.polyArray.length; j++) {
        if (this.polyArray[j][1] == a[i][1]) //Checks if exponent in polynomial a is the same as exponent
          a[i][0] += this.polyArray[j][0];
      }
      for (int j = 0; j < other.polyArray.length; j++) {
        if (other.polyArray[j][1] == a[i][1]) //Checks if exponent in polynomial b is the same as exponent
          a[i][0] -= other.polyArray[j][0];
      }
    }

    int count = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i][0] != 0) //Counts the number of terms in new array that don't have coefficient of 0
        count++;
    }

    int[][] b = new int[count][2]; //Creates another nre array that will contain final polynomial
    int j = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i][0] != 0) { //Checks if coefficent isn't 0
        b[j][0] = a[i][0];
        b[j][1] = a[i][1];
        j++;
      }
    }

    return(new Polynomial(b));
  }

  Polynomial mult(Polynomial other) {
    int size = this.polyArray.length * other.polyArray.length;
    int[][] a = new int[size][2]; //Creates array that stores every term multiplied with each other
    int g = 0;
    for (int i = 0; i < this.polyArray.length; i++) {
      for (int j = 0; j < other.polyArray.length; j++) {
        a[g][0] = this.polyArray[i][0] * other.polyArray[j][0]; //Multiplies coefficents
        a[g][1] = this.polyArray[i][1] + other.polyArray[j][1]; //Adds exponents
        g++;
      }
    }
    IntList exp = new IntList();
    for (int i = 0; i < a.length; i++) {
      if (!exp.hasValue(a[i][1])) //Checks for distinct exponents
        exp.append(a[i][1]);
    }
    exp.sortReverse(); //Orders the exponents from highest to lowest
    if (exp.hasValue(0)) { //Moves exponent 0 to the end
      for (int i = 0; i < exp.size(); i++) {
        if (exp.get(i) == 0) {
          exp.remove(i);
          exp.append(0);
          break;
        }
      }
    }
    int[][] b = new int[exp.size()][2]; //creates new array without duplicate exponents
    for (int i = 0; i < b.length; i++) {
      b[i][1] = exp.get(i);
    }
    for (int i = 0; i < b.length; i++) {
      for (int j = 0; j < a.length; j++) {
        if (a[j][1] == b[i][1]) //Checks if the exponent in array a is the same as that of aray b
          b[i][0] += a[j][0];
      }
    }

    int count = 0;
    for (int i = 0; i < b.length; i++) {
      if (b[i][0] != 0) //Checks if coefficent of a term is 0
        count++;
    }

    int[][] c = new int[count][2]; //Creates new array with final simplified polynomial
    int j = 0;
    for (int i = 0; i < b.length; i++) {
      if (b[i][0] != 0) { //Removes terms that have coeficient 0
        c[j][0] = b[i][0];
        c[j][1] = b[i][1];
        j++;
      }
    }

    return(new Polynomial(c));
  }

  /**
   * Turn graphing on/off
   */
  void toggleGraphing(boolean shouldGraph) {
    this.graphing = shouldGraph;
    this.didGraph = false;
  }

  void toggleGraphing() {
    this.toggleGraphing(!this.graphing);
  }

  void graph(float xMin, float xMax) {
    float[][] coordinate = new float[width+1][2]; //Array to store coordinates value
    float unitsPerPixel = (xMax - xMin)/width; //The increment in x per pixel
    float yMin = 0;
    float yMax = 0;

    for (int i = 0; i < width+1; i++) {
      float ans = 0;
      for (int j = 0; j < this.polyArray.length; j++) {
        ans += this.polyArray[j][0]*pow(xMin + i*unitsPerPixel, this.polyArray[j][1]); //Finds the answer of every term and stores it in a final answer
      }
      if (i == 0) { //If first term, makes the minimum and maximum value the answer
        yMin = ans;
        yMax = ans;
      }
      coordinate[i][0] = xMin + i*unitsPerPixel; //Stores the value of x per pixel
      coordinate[i][1] = ans; //stores the y value for every x-value
      if (ans > yMax) //If y is bigger than current maximum, the maximum is changed to y
        yMax = ans;
      if (ans < yMin) //If y is less than current minimum, the minimum is changed to y
        yMin = ans;
    }

    for (int i = 0; i < width; i++) {
      strokeWeight(8);
      float y = map(coordinate[i][1], yMin - 100*(yMax-yMin)/height, yMax + 100*(yMax-yMin)/height, 0, height); //Finds the y value of the graph in the window

      // If the y value is not a number, just show a blank screen
      // The whole polynomial is messed up, usually happens when given incomplete inpute i.e x^
      if (Double.isNaN(y)) {
        this.didGraph = true;
        return;
      }

      point(i, height - y);
    }

    if (xMin <= 0 && xMax >= 0) { //If y-axis is within minimum and maximum x values
      strokeWeight(2);
      float x = map(0, xMin, xMax, 0, width); //finds location of y-axis in the window
      line(x, 0, x, height);

      fill(255, 0, 0);
      textSize(20);
      if (x > 100) { //Displays the y-axis values on the right if axis too close to the left edge
        textAlign(RIGHT);
        text(yMax + 100*(yMax-yMin)/height, x-5, 25);
        textAlign(RIGHT);
        text(yMin - 100*(yMax-yMin)/height, x-5, height-5);
      } else if (x < 700) { //Displays the y-axis values on the left if axis too close to the right edge
        textAlign(LEFT);
        text(yMax + 100*(yMax-yMin)/height, x+5, 25);
        textAlign(LEFT);
        text(yMin - 100*(yMax-yMin)/height, x+5, height-5);
      } else { //Prints the y-axis values on the left of the axis
        textAlign(LEFT);
        text(yMax + 100*(yMax-yMin)/height, x-5, 25);
        textAlign(LEFT);
        text(yMin - 100*(yMax-yMin)/height, x-5, height-5);
      }
    } else { //if y-axis is not within the bounds, displays maximum and minimum on the middle of the top and bottom edges of the window
      fill(255, 0, 0);
      textSize(20);
      textAlign(CENTER);
      text(yMax + 100*(yMax-yMin)/height, width/2, 25);
      textAlign(CENTER);
      text(yMin - 100*(yMax-yMin)/height, width/2, height-5);
    }

    if (yMin - 100*(yMax-yMin)/height <= 0 && yMax + 100*(yMax-yMin)/height >= 0) {
      strokeWeight(2);
      float y = height - map(0, yMin - 100*(yMax-yMin)/height, yMax + 100*(yMax-yMin)/height, 0, height);
      line(0, y, width, y);

      fill(255, 0, 0);
      textSize(20);
      if (y < 100) { //Displays the x-axis values on the bottom of the axis if too close to the top edge
        textAlign(LEFT);
        text(xMin, 5, y+25);
        textAlign(RIGHT);
        text(xMax, width-5, y + 25);
      } else if (y > 700) { //Displays the x-axis values on the top of the axis if too close to the bottom edge
        textAlign(LEFT);
        text(xMin, 5, y-5);
        textAlign(RIGHT);
        text(xMax, width-5, y-5);
      } else { //Prints the x-axis values on the top of the axis
        textAlign(LEFT);
        text(xMin, 5, y-5);
        textAlign(RIGHT);
        text(xMax, width-5, y-5);
      }
    } else { //if x-axis is not within the bounds, displays maximum and minimum on the middle of the left and right edges of the window
      fill(255, 0, 0);
      textSize(20);
      textAlign(LEFT);
      text(xMin, 25, height/2+25);
      textAlign(RIGHT);
      text(xMax, width-5, height/2+25);
    }

    this.didGraph = true;
  }

  void graph() {
    this.graph(-5, 5);
  }

  FloatList roots(boolean shouldPrint) {
    int[][] polyArray2 = copy2dArray(this.polyArray);
    int c = abs(polyArray2[polyArray2.length-1][0]); // constant
    int q = abs(polyArray2[0][0]); // leading coefficient
    boolean hasConstant = polyArray2[polyArray2.length-1][1] == 0;
    IntList factors_c = new IntList();
    IntList factors_q = new IntList();
    FloatList factors = new FloatList();
    FloatList zeroes = new FloatList();

    if (!hasConstant) {
      zeroes.append(0);

      while (polyArray2[polyArray2.length-1][1] != 0) {
        for (int i = 0; i < polyArray2.length; i++) {
          polyArray2[i][1]--;
        }
      }
    }

    for (int i = 1; i <= c; i++) { //FIND FACTORS
      if (c % i == 0) {
        factors_c.append(i);
      }
    }
    for (int i = 1; i <= q; i++) {
      if (q % i == 0) {
        factors_q.append(i);
      }
    }
    for (int i = 0; i < factors_c.size(); i++) {
      for (int j = 0; j < factors_q.size(); j++) {
        factors.append((float)factors_c.get(i)/factors_q.get(j));
        factors.append(-(float)factors_c.get(i)/factors_q.get(j));
      }
    }
    //test if number equals to 0
    for (int i = 0; i < factors.size(); i++) {
      float f = factors.get(i);
      float v = 0;
      //println(f);
      for (int j = 0; j < polyArray2.length; j++) {
        v += polyArray2[j][0] * pow(f, polyArray2[j][1]);
      }
      //println("v is " + str(v));
      if (v == 0 && !zeroes.hasValue(f)) { // Check for duplicate roots
        zeroes.append(f);
      }
    }

    if (shouldPrint) {
      println(zeroes);

      if (zeroes.size() == 0) {
        println("This function has no rational roots.");
      } else if (zeroes.size() == 1) {
          println("The rational root of this function is", zeroes.get(0) + ".");
      } else {
          print("The rational roots of this function are ");

          for (int i = 0; i < zeroes.size() - 1; i++) {
              print(Float.toString(zeroes.get(i)) + ", ");
          }

          println(zeroes.get(zeroes.size() - 1));
      }
    }

    return zeroes;
  }

  FloatList roots() {
    return this.roots(true);
  }

  Polynomial derive(){ // finds the derivative of a polynomial
    int[][] newArray = deepCopyIntArray(this.polyArray);

    println(this);

    println("[");
    for (int i=0; i<this.polyArray.length; i++) {
      println("   ", this.polyArray[i][0], ",", this.polyArray[i][1]);
    }
    println("]");

    println("[");
    for (int i=0; i<this.polyArray.length; i++) {
      println("   ", newArray[i][0], ",", newArray[i][1]);
    }
    println("]");

    for (int i=0; i<this.polyArray.length; i++) {
      newArray[i][0] = this.polyArray[i][0] * this.polyArray[i][1]; // multiplies the coefficient by the exponent of each term and sets it as the coefficient of the new polynomial
      newArray[i][1] = this.polyArray[i][1] - 1; // decreases the exponent of each term by 1
    }

    if (newArray[newArray.length-1][1] < 0) { // if the polynomial has a constant, this gets rid of the constant column in the 2d array
      newArray[newArray.length-1][1] = 0;
      int[][] shorter = new int[newArray.length-1][2]; // makes a new polynomial array without the constant junk
      for (int i = 0; i < shorter.length; i++) {
        shorter[i][0] = newArray[i][0];
        shorter[i][1] = newArray[i][1];

      }
      newArray = shorter;
    }

    return(new Polynomial(newArray));
  }

  FloatList findMinMax(){ // finds the rational minimas/maximas of a polynomial

    Polynomial q = this.derive(); // finds the derivative

    FloatList m = q.roots();

    if (m.size() == 0) {
      println("This function has no rational minima/maxima.");
    } else if (m.size() == 1) {
        println("The rational minima/maxima of this function is located at ", m.get(0) + ".");
    } else {
        print("The rational minimas/maximas of this function are located at ");

        for (int i = 0; i < m.size() - 1; i++) {
            print(Float.toString(m.get(i)) + ", ");
        }

        println(m.get(m.size() - 1));
    }

    return m;
  }

}
