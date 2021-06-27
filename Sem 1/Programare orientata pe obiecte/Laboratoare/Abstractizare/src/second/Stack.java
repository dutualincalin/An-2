package second;

import first.Task;


public class Stack extends AbstractContainer {

    public Task pop(){
        if(isEmpty()) return null;
        Task popTask = list.get(0);
        list.remove(0);
        return popTask;
    }

}
