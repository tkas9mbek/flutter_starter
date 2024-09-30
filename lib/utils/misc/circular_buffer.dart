class CircularBuffer {
  final int size;

  late List<double> buffer;

  int currentIndex = 0;
  int count = 0;

  CircularBuffer(this.size) {
    buffer = List.filled(size, 0);
  }

  void add(double value) {
    buffer[currentIndex] = value;
    currentIndex = (currentIndex + 1) % size;
    count = count < size ? count + 1 : size;
  }

  double get average {
    if (count == 0) {
      return 0;
    }

    final sum = buffer.reduce((value, element) => value + element);

    return sum / count;
  }

  double get mean {
    if (count == 0) {
      return 0;
    }

    buffer.sort();

    if (count.isEven) {
      final middle1 = (count ~/ 2) - 1;
      final middle2 = count ~/ 2;

      return (buffer[middle1] + buffer[middle2]) / 2;
    } else {
      final middle = count ~/ 2;

      return buffer[middle];
    }
  }

  double? meanWithDeviation(double deviationThreshold) {
    buffer.sort();

    if (_calculateDeviation() > deviationThreshold) {
      return null;
    }

    return mean;
  }

  double _calculateDeviation() {
    final deviations = buffer.map((value) => (value - average).abs());
    final maxDeviation = deviations.reduce((max, value) => max > value ? max : value);

    return maxDeviation;
  }
}
