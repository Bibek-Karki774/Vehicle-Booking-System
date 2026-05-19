<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/payment.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="payment-body">

<div class="payment-card">

    <div class="payment-header">
        <h2>Payment Details</h2>
    </div>

    <!-- Booking Summary -->
    <div class="booking-summary">
        <div class="summary-row">
            <span>Start Date</span>
            <strong>${fromDate}</strong>
        </div>
        <div class="summary-row">
            <span>End Date</span>
            <strong>${toDate}</strong>
        </div>
        <div class="summary-row">
            <span>Total Days</span>
            <strong>${days}</strong>
        </div>

        <!-- Total amount -->
        <div class="summary-row" style="border-top:1px solid #e5e7eb; padding-top:8px; margin-top:4px;">
            <span><strong>Total</strong></span>
            <strong style="color:#2563eb;">Rs ${totalAmount}</strong>
        </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/booking">
        <input type="hidden" name="action"      value="confirm"/>
        <input type="hidden" name="vehicleId"   value="${vehicleId}"/>
        <input type="hidden" name="fromDate"    value="${fromDate}"/>
        <input type="hidden" name="toDate"      value="${toDate}"/>
        <input type="hidden" name="totalAmount" value="${totalAmount}"/>

        <div class="form-field">
            <label>Cardholder Name</label>
            <input type="text" placeholder="John Doe" required/>
        </div>

        <div class="form-field">
            <label>Card Number</label>
            <input type="text" placeholder="1234 5678 9012 3456" maxlength="19" required/>
        </div>

        <div class="form-row">
            <div class="form-field">
                <label>Expiry Date</label>
                <input type="text" placeholder="MM/YY" maxlength="5" required/>
            </div>
            <div class="form-field">
                <label>CVV</label>
                <input type="text" placeholder="123" maxlength="3" required/>
            </div>
        </div>

        <label class="save-card">
            <input type="checkbox" name="saveCard">
            Save card for future payments
        </label>

        <button type="submit" class="btn-pay">
            <i class="fas fa-lock"></i> Confirm Payment
        </button>

    </form>

    <a href="${pageContext.request.contextPath}/vehicles" class="btn-back">
        <i class="fas fa-arrow-left"></i> Go Back
    </a>

</div>

</body>
</html>