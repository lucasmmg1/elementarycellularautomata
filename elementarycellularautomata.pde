int RULESET_ID = 110;
int[] cells;
int w = 5;
int yPos = 0;

void setup()
{
  size(750, 750);
  cells = new int[width / w];
  
  for (int x = 0; x < cells.length; x++)
    cells[x] = 0;
    
  cells[cells.length / 2] = 1;
}
void draw()
{    
  for (int x = 0; x < cells.length; x++)
  {
    int xPos = x * w;
    noStroke();
    fill(255 - cells[x] * 255);
    square(xPos, yPos, w);
  }
    
  int[] newCells = new int[cells.length];
  for (int x = 0; x < newCells.length; x++)
    newCells[x] = Ruleset(x - 1 < 0 ? cells[cells.length - 1] : cells[x - 1], cells[x], x + 1 == cells.length ? cells[0] : cells[x + 1]);
  cells = newCells;
  yPos += w;
}

void DrawAutomaton()
{
  int[] newCells = new int[cells.length];
  for (int i = 0; i < newCells.length; i++)
    newCells[i] = Ruleset(cells[(i - 1 + cells.length) % cells.length], cells[i], cells[(i + 1 + cells.length) % cells.length]);
  cells = newCells;
}
int Ruleset(int a, int b, int c)
{
  String binRule = Integer.toBinaryString(RULESET_ID);
  while (binRule.length() < 8)
    binRule = "0" + binRule; 
  
  StringBuilder reversed = new StringBuilder(binRule);
  reversed.reverse();
  String neighborhood = "" + a + b + c;
  int value = parseInt(neighborhood, 2);
  return parseInt(String.valueOf(reversed.charAt(value % reversed.length()))); 
}
