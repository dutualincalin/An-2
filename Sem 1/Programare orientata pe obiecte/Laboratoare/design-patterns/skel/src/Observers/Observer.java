package Observers;

import storage.SensorData;

public interface Observer {
    void update(SensorData data);
}
