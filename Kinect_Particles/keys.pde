void keyPressed() {

  switch (key) {
  
    case 'q':
      threshholdMax += 10;
      break;
      
    case 'a':
      threshholdMax -= 10;
      break;
      
    case 's':
      threshholdMin += 10;
      break;
      
    case 'x':
      threshholdMin -= 10;
      break;
  }

}