package task3_and_4;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String []args){
        ArrayList<Integer> array = new ArrayList<>() ;
        array.add(1);
        array.add(3);
        array.add(2);

        MyImmutableArray array2 = new MyImmutableArray(array);
        List<Integer> array3 = array2.getArray();

        System.out.println(array3);

        // Daca rulez swap-ul asta imi da eroare la compilare
        //
        // int aux = array3.get(2);
        // array3.set(2, array3.get(1));
        // array3.set(1, aux);

        System.out.println(array3);
    }

}
