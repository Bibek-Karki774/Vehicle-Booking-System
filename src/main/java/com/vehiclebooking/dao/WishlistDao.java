package com.vehiclebooking.dao;

import com.vehiclebooking.entity.Wishlist;
import java.util.ArrayList;

public interface WishlistDao {

    boolean insertWishlist(Wishlist wishlist);

    ArrayList<Wishlist> fetchWishlistByCustomerId(int customerId);

    boolean deleteWishlist(int wishlistId);


}