package util

const (
	USD = "USD"
	EUR = "EUR"
	CAD = "CAD"
	INR = "INR"
	YEN = "YEN"
)

func IsSupportedCurrency(currency string) bool {
	switch currency{
	case USD, EUR, CAD, INR, YEN:
		return true
	}
	return false
}