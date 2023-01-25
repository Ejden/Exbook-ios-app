import UIKit

let regex = /(Authorization)(=)(.+)(; )(Max-Age)(=)([0-9]+)(; )(Expires)(=)(.*)(; )(Path)(=)(.*)/
let string = "Authorization=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGphbi5rb3dhbHNraSIsImV4cCI6MTY3NDQyNDQyNywiYXV0aG9yaXRpZXMiOiJbUk9MRV9VU0VSLCBTRUFSQ0hfQk9PS1MsIEVYQ0hBTkdFX0JPT0tTLCBSRUFEX0FCT1VUX01FXSJ9.7C71uVzUqwAklKektyn4wwXD6LxSI7OFFX2JvOWak0Q; Max-Age=36000000; Expires=Thu, 14-Mar-2024 03:53:47 GMT; Path=/"


if let match = string.firstMatch(of: regex) {
    print(match.output.123)
}
