// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20, IUniswapV2Router} from "./interface.sol";

contract swapCode {

    address private constant UNISWAP_V2_ROUTER =  0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant usdcContract =  0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address private constant WETHContract =  0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function swapUSDCforETH(uint amountIn, uint256 amountOutMin, address _to) public {
        
        require(IERC20(usdcContract).transferFrom(msg.sender, address(this), amountIn), 'transferFrom failed');

        require(IERC20(usdcContract).approve(UNISWAP_V2_ROUTER, amountIn), 'approve failed');

        address[] memory path = new address[](2);
        path[0] = address(usdcContract);
        path[1] = address(WETHContract);
        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForETH(amountIn, amountOutMin, path, _to, block.timestamp);
    }

    function swapETHforUSDC(uint amountIn, address _to) external {
        
        require(IERC20(WETHContract).transferFrom(msg.sender, address(this), amountIn), 'transferFrom failed');

        require(IERC20(WETHContract).approve(UNISWAP_V2_ROUTER, amountIn), 'approve failed');

        address[] memory path = new address[](2);
        path[0] = WETHContract;
        path[1] = usdcContract;

        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactETHForTokens(0, path, _to, block.timestamp);
    }


}