extension IntegerHelper on int {
  bool between(int low, int high) => this <= high && this >= low;
  bool outside(int low, int high) => this >= high && this <= low;

  int highest(int input) => input >= this ? input : this;
  int lowest(int input) => input <= this ? input : this;
}
