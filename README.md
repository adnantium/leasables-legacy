
# Leasables 

The Leasables smart contract protocol models the Lessor/Lessee relationship and facilitates its execution thru the transaction's lifecycle. The lease contract captures the essential elements of a lease agreement for any asset or resource such as:

* start and end times of the lease term
* pickup & return locations and conditions
* holding deposit and security funds in escrow
* key identifying attributes of the object
* terms of use for the lessee
* the lessor's responsibilities during the lease
* payment rate and method

Using Leasables, 2 participants in a network can come to an agreement on the terms of a lease that will be initiated, executed and enforced by a set of smart contracts in a trustless environment such as Ethereum.

Each lease agreement's primary representation is a digital smart contract but it can also generate a corresponding traditional version in english (legalese) that is legally admissible in court if things go bad with the deal.

This initial implementation is specialized for leasing cars but the underlying concepts apply to any object/asset/resource can be "rented" for a period of time.

Implementing the lease transaction as a smart contract gives us all the benefits of doing business on a decentralized trustless platform where the transactions can cost less and run more securely and efficiently. The lessor & lessee execute the deal without an intermediary between them. The network provides all the trust needed as it serves as witness to:
* what was agreed on in the contract
* what is the current state at each step
* what needs to be done to complete the transaction



## Setup

4. Install [NodeJS](https://nodejs.org)
    * OSX: Use Homebrew and `brew install node` else be prepared to do a lot of `sudo` commands later.
5. `npm install truffle`
6. `npm install openzeppelin-solidity`
7. `npm install web3`
8. `git clone https://github.com/adnan214/leasables.git`
9. `cd leasables`
10. `export PATH=$PATH:$(PWD)/node_modules/.bin`
11. 






