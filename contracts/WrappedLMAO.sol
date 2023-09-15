
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./lmao-token.sol";

contract WrappedLMAO is ERC20 {
    IERC20 LmaoToken;

    constructor(address _originalToken) ERC20("WrappedLMAO", "WLMAO") {
        LmaoToken = IERC20(_originalToken);
        _mint(address(this), 1000e18);
    }

    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        LmaoToken.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(LmaoToken.balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
        require(LmaoToken.transfer(msg.sender, amount), "Transfer failed");
    }
}
