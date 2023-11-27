// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LMAOTOKEN is ERC20 {
    address[] public addressFees;
    uint256 private constant FEE_PERCENTAGE = 8;
    address private owner;

    constructor() ERC20("LMAOTOKEN", "LMAO") {
        owner = msg.sender;
        _mint(msg.sender, 10000e18);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount must be greater than 0");
        
        uint256 networkFee = (amount * 8) / 100;
        uint256 finalAmount = amount - networkFee;

        _transfer(msg.sender, owner, networkFee); 
        _transfer(msg.sender, recipient, finalAmount); 
        
        return true;
    }
    
}
