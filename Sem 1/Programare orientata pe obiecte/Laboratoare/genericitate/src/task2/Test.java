package task2;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class Test {
    public static  <T extends Sumabil> void getSum(Collection<T> c){
        Iterator<T> iterator = c.iterator();
        T sum = iterator.next();
        while(iterator.hasNext()){
            sum.addValue(iterator.next());
        }

        System.out.println(sum);
    }

    public static void main(String []args){
       MyVector3 vector1 = new MyVector3(1, 1, 1);
       MyVector3 vector2 = new MyVector3(2, 2, 2);
       MyVector3 vector3 = new MyVector3(1, 2, 3);
       vector1.addValue(vector2);
       vector1.addValue(vector3);
       vector2.addValue(vector3);

       System.out.println("For vectors:");
       Collection<Sumabil> collection1 = new ArrayList<>();
       collection1.add(vector1);
       getSum(collection1);
       collection1.add(vector2);
       getSum(collection1);
       collection1.add(vector3);
       getSum(collection1);

       int[][] matrix1 = new int[4][4];
       int[][] matrix2 = new int[4][4];
       int[][] matrix3 = new int[4][4];


       int i, j ;
       for(i = 0; i < 4; i++){
           for(j = 0; j < 4; j++){
               matrix1[i][j] = 1;
               matrix2[i][j] = 2;
               matrix3[i][j] = 3;
           }
       }

       MyMatrix myMatrix1 = new MyMatrix(matrix1);
       MyMatrix myMatrix2 = new MyMatrix(matrix2);
       MyMatrix myMatrix3 = new MyMatrix(matrix3);

       System.out.println("For matrices:");
       myMatrix1.addValue(myMatrix2);
       System.out.println(myMatrix1);
       myMatrix1.addValue(myMatrix3);
       myMatrix2.addValue(myMatrix3);

       Collection<Sumabil> collection2 = new ArrayList<>();
       collection2.add(myMatrix1);
       getSum(collection2);
       collection2.add(myMatrix2);
       getSum(collection2);
       collection2.add(myMatrix3);
       getSum(collection2);
    }
}
