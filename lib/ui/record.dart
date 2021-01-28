class Record implements Comparable<Record>{

  Record(this.score, this.name); 

  int score; 
  String name;

  @override
  int compareTo(Record other) {
    return score + other.score;
  } 
}