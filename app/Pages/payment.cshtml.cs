using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class PaymentModel : PageModel
{
    private readonly ILogger<PaymentModel> _logger;

    public PaymentModel(ILogger<PaymentModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
