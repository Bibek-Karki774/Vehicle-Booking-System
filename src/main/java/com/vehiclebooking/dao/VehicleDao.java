package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Vehicle;
import java.util.ArrayList;


public interface VehicleDao {

    boolean insertVehicle(Vehicle vehicle);

    ArrayList<Vehicle> getAllVehicles();

    boolean updateVehicle(Vehicle vehicle);

    boolean deleteVehicle(int vehicleId);

    ArrayList<Vehicle> searchVehiclesByName(String keyword);

    ArrayList<Vehicle> filterVehiclesByType(String vehicleType);
}