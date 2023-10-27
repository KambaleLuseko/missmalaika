<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    payment
    <form action="https://cardpayment.flexpay.cd/v1/pay" method="POST">
        <input placeholder="authorization" type="text" name="authorization">
        <input placeholder="merchant" type="text" name="merchant">
        <input placeholder="reference" type="text" name="reference">
        <input placeholder="amount" type="text" name="amount">
        <input placeholder="currency" type="text" name="currency">
        <input placeholder="description" type="text" name="description">
        <input placeholder="callback_url" type="text" name="callback_url">
        <input placeholder="approve_url" type="text" name="approve_url">
        <input placeholder="cancel_url" type="text" name="cancel_url">
        <input placeholder="decline_url" type="text" name="decline_url">
        <input type="submit" value="valider">
    </form>
</body>

</html>