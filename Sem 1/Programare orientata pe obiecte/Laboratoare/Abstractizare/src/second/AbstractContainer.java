package second;

import first.Task;

import java.util.ArrayList;

public abstract class AbstractContainer implements Container{
    public ArrayList<Task> list = new ArrayList<>();

    public Task pop(){
        return list.get(0);
    }

    public void push(Task task){
        list.add(0,task);
    }

    public int size(){
        return this.list.size();
    }

    public boolean isEmpty(){
        return size() == 0;
    }

    public void transferFrom(Container container){
        while(container.size() != 0){
            push(container.pop());
        }
    }

    public ArrayList<Task> getTasks(){
        return list;
    }


}
