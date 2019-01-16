(function(){
	"use strict";
	var result = "";
	var left = "";
	var right = "";
	var operator = "";
	var accumulating = true;
	var pointExists = false;
	var opSelected = false;

	function clear() {
		result = "";
		left = "";
		right = "";
		operator = "";
		accumulating = true;
		pointExists = false;
		opSelected = false;
		document.getElementById('calc-screen').innerHTML = "";
	}

	function printLog() {
		console.log("result: " + result + ", " +
					"left: " + left + ", " +
					"right: " + right + ", " +
					"operator: " + operator + ", " +
					"accumulating: " + accumulating + ", " +
					"pointExists: " + pointExists + ", " +
					"opSelected: " + opSelected);
	}

	function compute() {
		if (left == "" && right != "") {
			left = 0;
		}
		if(left != "" && right != "") {
			left = parseFloat(left);
			right = parseFloat(right);

			switch(operator) {
				case '+':
					result = left + right;
					break;
				case '-':
					result = left - right;
					break;
				case '/':
					result = left / right;
					break;
				default:
					result = left * right;
					break;
			}

			left = result;
			right = "";
			displayResult();
			accumulating = true;
			pointExists = false;

		}
	}

	function displayResult() {
		document.getElementById('calc-screen').innerHTML = result;
	}

	function addDecimal() {
		if (!pointExists && accumulating) {
			right = right + ".";
			pointExists = true;
		}
		displayRight();
	}

	function displayRight() {
		document.getElementById('calc-screen').innerHTML = right;
	}
	
	function updateNumber(newDigit) {
		if(!accumulating && right != ""){
			left = right;
			right = newDigit;
			accumulating = true;
		} else {
			right = right + newDigit;
		}
		displayRight();
	}

	function updateOp(op) {
		opSelected = true;
		operator = op;
		accumulating = false;
		pointExists = false;
	}

	function clicked(ev){
		var id = ev.target.getAttribute('data-btn-id');
		switch (id) {
			case 'c': 
				clear();
				printLog();
				break;
			case '+': 
				if(opSelected) {
					opSelected = false;
					compute();
				} else {
					updateOp('+');
					compute();
				}
				printLog();
				break;
			case '-': 
				updateOp('-');
				printLog();
				break;
			case '*':
				updateOp('*');
				printLog();
				break;
			case '/':
				updateOp('/');
				printLog();
				break;
			case '.':
				addDecimal();
				printLog(); 
				break;
			default: 
				updateNumber(id);
				printLog();
		}
	}

	function init(){
		var btns = document.getElementsByTagName("Button");
		for (var i = btns.length - 1; i >= 0; i--) {
			btns[i].addEventListener('click', function(ev){clicked(ev)});
		}
	}

	document.addEventListener('DOMContentLoaded', init());
})();