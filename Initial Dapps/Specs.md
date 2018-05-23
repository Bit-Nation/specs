# Dapp Specifications

## Simple Auction
To initialize the simple auction smart contract just create the Smart contract with the following parameters:
1. `Duration`: How long the auction will last in seconds starting from now.
2. `Beneficiary`: The person who's receiving the ether after the auction ends.

The auction contract exposes 3 functions.

`bid()`: Callable without any parameters, just sent from the bidder with a value attached to the transaction.
The value must be higher than the current highest bid.

`withdraw()`: Callable without any parameters, by any bidder to withdraw a bid that was overbid.

`auctionEnd()`: Callable without any parameters, ends the auction and sends the funds to the beneficiary specified when creating the contract.

## One Time Purchase
To initialize the OneTimePurchase smart contract pass in the following parameters when creating the smart contract:
1. `Price`: How much is the product going to be sold for? (Price in wei)
2. `Description`: A short description describing the product being sold.
3. `Seller`: Who is selling the product? This address will be able to withdraw the funds from the contract.

The contract exposes 4 functions.
`buyItem()`: Callable without any parameters, just sent from the buyer with the sell price attached as the value in the transaction.
Call will fail if there is not enough ether sent.

`withdraw()`: Callable without any parameters, withdraws all the ether stored in the contract to the seller's ethereum address.

`endSale()`: Callable without any parameters and by the seller only. Destroys the sale contract and sends all remaining ether to the seller.

`checkCustomer(address customer)`: Callable by passing the ethereum address of the customer being checked. This will return an uint of the number of times
this customer has purchased this item.