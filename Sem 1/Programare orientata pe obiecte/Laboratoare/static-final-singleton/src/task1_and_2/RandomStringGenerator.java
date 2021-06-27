package task1_and_2;

import java.util.Random;

class RandomStringGenerator {

    private Random generator = new Random();

    private int size;
    private char[] alphabet;

    RandomStringGenerator(final int s, final String a) {
        this.size = s;
        this.alphabet = a.toCharArray();
    }

    String next() {
        char[] randString = new char[size];

        for (int i = 0; i < size; i++) {
            randString[i] = alphabet[generator.nextInt(alphabet.length)];
        }

        return new String(randString);
    }
}
