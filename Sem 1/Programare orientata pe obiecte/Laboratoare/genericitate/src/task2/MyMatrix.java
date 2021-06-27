package task2;

public class MyMatrix implements Sumabil{
    private final int[][] matrix;

    public MyMatrix(int[][] matrix){
        this.matrix = matrix;
    }


    @Override
    public void addValue(Sumabil value) {
        int i, j;
        if(value instanceof MyMatrix) {
            for (i = 0; i < 4; i++) {
                for (j = 0; j < 4; j++) {
                    matrix[i][j] += ((MyMatrix) value).matrix[i][j];
                }
            }
        }
    }

    @Override
    public String toString() {
        int i, j;
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 3; j++) {
                System.out.print(matrix[i][j] + " ");
            }

            System.out.println(matrix[i][j]);
        }

        return "";
    }
}
