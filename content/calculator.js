/**
    This file created by Michael Savchenko (Tech Lead software developer)
    17 September 2020
    Dreamkas, Saint-Petersburg, Russian Federation

    Description: calculator engine for QML view - calculator
        Available operation: +, -, x
        Default precision:  2 decimal places in result of calculation
                            3 decimal places in each digits group
**/
var precDigits = 3      // available digit precision
let precRes = 2         // available result of calculation precision
let dot = "."           // dot symbol
let comma = ","         // comma symbol
let multiply = "*"      // multiply symbol
let plus = "+"          // plus symbol
let minus = "-"         // minus symbol
let del = "backspace"   // del symbol
var digits = ""         // current digits group
var digitsArr = [""]    // array of current digits groups
var lastSymbol = ""     // last digit or operator symbol of formula
var result = "0.00"

function reset() {
    digits = ""
    digitsArr = [""]
    lastSymbol = ""
    result = "0.00"
    setPrecDigits(3)
}

function setPrecDigits(prec) {
    if (prec > 0) {
        precDigits = prec
    }
}

/**
 * @brief getPrec get precision of digit group
 * @param digitGroup {string} digit group
 * return {number} precision of digit group
 */
const getPrec = digitGroup => ( (digitGroup.toString().includes(comma)) ? (digitGroup.toString().split(comma).pop().length) : (0) )
/**
 * @brief formatResult formatter result of calculation string
 * @param result {string} result of calculation string
 * return {string} result of calculation string (formatted)
 */
function formatResult(result) {
  var parts = result.toString().split(dot);
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
  return parts.join(dot);
}

function formatCommaResult(result) {
  var parts = result.toString().split(comma);
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
  return parts.join(comma);
}

function getResNumber() {
    console.log(result)
    return (result === "undefined") ? 0 : Number(result)
}

function parseFormula() {
    result = calc(calculatorPage.formulaStr)
    digits = calculatorPage.formulaStr
    digitsArr[digitsArr.length - 1] = digits
    lastSymbol = calculatorPage.formulaStr.substring(0, calculatorPage.formulaStr.length - 1)
}

function getRes() {
    result = result.replace(dot, comma)
    return formatResult(result)
}
/**
 * @brief getRes string formula calculate
 * @param formula {string} string formula
 * return {string} result of calculation
 */
function calc(formula) {
    var res = "0.00"
    try {
        var tmp = formula
        tmp = tmp.replace(/,/g, dot)

        if (tmp.toString()) {
            res = eval(tmp.toString()).toFixed(precRes)
        }
    }
    catch (e) {
        console.error("calc ops!")
        res = eval(tmp.substring(0, tmp.length - 1)).toFixed(precRes)
    }    
    return res
}
/**
 * @brief isOperator check operator symbol
 * @param symbol {string} symbol
 * return {bool} is operator symbol
 */
function isOperator(symbol) {
    return !((symbol >= "0") && (symbol <= "9"))
}
/**
 * @brief disabled availability check of symbol into formula
 * @param symbol {string} symbol
 * return {bool} result of check
 */
function disabled(symbol) {
    if (symbol != del) {
        if (isOperator(symbol) && ((calculatorPage.formulaStr.length == 0) || (isOperator(lastSymbol)))) {
            console.warn("Operator: " + symbol + " disabled!")
            return true
        } else if ((digits.length == 0) && (symbol == comma)) {
            console.warn("Comma in the start of digits group!")
            return true
        } else if (isOperator(lastSymbol) && (symbol == comma)) {
            console.warn("Comma after operator: " + lastSymbol + " !")
            return true
        } else if ((lastSymbol == comma) && isOperator(symbol)) {
            console.warn("Operator: " + symbol + " after comma!")
            return true
        } else if ((symbol == comma) && (digits.toString().search(/\,/) != -1)) {
            console.warn("Dublicate comma in digits group!")
            return true
        } else if ((digits.toString().search(/\,/) == -1) && (digits.length == 1) && (lastSymbol == "0") && !isOperator(symbol)) {
            console.warn("Digit: " + symbol + " after zero in start digits group!")
            return true
        } else if (!isOperator(symbol) && (getPrec(digits) >= precDigits)) {
            console.warn("Max precision: " + precDigits + " complite!")
            return true
        }
    }
    return false
}
/**
 * @brief digitPressed add digit symbol into formula
 * @param symbol {string} digit symbol
 */
function digitPressed(symbol)
{
    if (disabled(symbol))
        return

    var res = calc(calculatorPage.formulaStr + symbol)
    if (res.valueOf() > 9999999999999.99) {
        console.warn("Result (" +  res + ") limit complited!")
        return
    }
    result = res

    if ((lastSymbol.toString().length == 1) && (!isOperator(lastSymbol) || lastSymbol == comma)) {
        digits = digits + symbol.toString()
    } else {
        digits = symbol
    }
    calculatorPage.formulaStr += symbol.toString()
    digitsArr[digitsArr.length - 1] = digits
    lastSymbol = symbol
}
/**
 * @brief digitPressed add operator symbol into formula
 * @param symbol {string} operator symbol
 */
function operatorPressed(symbol)
{
    if (disabled(symbol))
        return

    if (symbol == plus || symbol == minus || symbol == multiply) {
        digits = ""
        digitsArr.push(digits)
        lastSymbol = symbol
        calculatorPage.formulaStr += symbol
    }
    else if (symbol == del) {
        if (calculatorPage.formulaStr.length > 0) {
            let newFormulaStr = calculatorPage.formulaStr.substring(0, calculatorPage.formulaStr.length - 1)
            result = calc(newFormulaStr)
            calculatorPage.formulaStr = newFormulaStr
        }

        if ((digits.length > 0) && ((lastSymbol == comma) || !isOperator(lastSymbol))) {
            digits = digits.substring(0, digits.length - 1)

            if (digits.length == 0) {
                digitsArr.pop()
                if (digitsArr.length == 0) {
                    digitsArr = [""]
                }
                digits = digitsArr[digitsArr.length - 1]
            }
        } else
            digitsArr[digitsArr.length - 1] = digits

        if (calculatorPage.formulaStr.length > 0)
            lastSymbol = calculatorPage.formulaStr.slice(calculatorPage.formulaStr.length - 1)
        else
            lastSymbol = ""
    }
}
