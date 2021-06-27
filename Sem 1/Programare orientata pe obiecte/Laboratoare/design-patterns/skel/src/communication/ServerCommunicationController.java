package communication;

import Observers.Observer;
import main.Utils;
import storage.SensorData;

public class ServerCommunicationController implements Observer {
    private SensorData dataRecord;

    public ServerCommunicationController(){
        dataRecord = new SensorData(0,0);
    }

    @Override
    public void update(SensorData arg) {
        dataRecord = arg;
    }

    public String getServerCommunicationControllerMessage(){
        ServerMessage message = new ServerMessage(dataRecord.getStepsCount(), Utils.getClientId(),
                dataRecord.getTimestamp());

        return ("Server: " + message);
    }


}
