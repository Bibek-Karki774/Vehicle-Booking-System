package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Vehicle;
import java.util.ArrayList;


public interface VehicleDao {

    boolean insertVehicle(Vehicle vehicle);

    ArrayList<Vehicle> getAllVehicles();

    boolean updateVehicle(int vehicleId, Vehicle vehicle);

    boolean deleteVehicle(int vehicleId);

    Vehicle getVehicleById(int vehicleId);
    ArrayList<Vehicle> searchVehicles(String keyword);
}