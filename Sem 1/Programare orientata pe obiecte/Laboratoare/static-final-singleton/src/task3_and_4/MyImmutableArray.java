package task3_and_4;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class MyImmutableArray {
    final ArrayList<Integer> immutableArray;

    MyImmutableArray(ArrayList<Integer> vector){
        immutableArray = new ArrayList<>(vector);
    }

    List<Integer> getArray(){
        return Collections.unmodifiableList(immutableArray);
    }
}
