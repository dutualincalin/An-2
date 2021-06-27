package second;

import first.Task;

public class Queue extends AbstractContainer {

    public Task pop(){
        if (isEmpty()) return null;
        Task popTask = list.get(size() - 1);
        list.remove(size() - 1);
        return popTask;
    }
}
