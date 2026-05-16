package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Wishlist;
import java.util.ArrayList;

public interface WishlistDao {

    boolean insertWishlist(Wishlist wishlist);

    ArrayList<Wishlist> fetchWishlistByUserId(int customerId);

    boolean deleteWishlist(int wishlistId);
    boolean deleteAllByUserId(int userId);
    void toggleWishlist(int userId, int vehicleId);
    void deleteByUserIdAndVehicleId(int userId, int vehicleId);
}