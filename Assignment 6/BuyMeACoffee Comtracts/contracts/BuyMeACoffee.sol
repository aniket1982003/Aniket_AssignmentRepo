// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] public memos;

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev Buy a coffee for the contract owner
     * @param _name Name of the coffee buyer
     * @param _message A nice message from the coffee buyer
     */
    function buyACoffee(
        string memory _name,
        string memory _message
    ) public payable {
        require(msg.value > 0, "Can't buy a coffee with 0 MATIC.");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    /**
     * @dev save the entire balance stored in thisa contract to the owner
     */
    function withdrawTips() public {
        require(msg.sender == owner, "Only the owner can withdraw the tips");
        require(address(this).balance > 0, "No balance to withdraw");
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }

    /**
     * @dev retrive all the memos received and stored on the blockchain
     */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
