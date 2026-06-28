using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class SigninModel : PageModel
{
    private readonly ILogger<SigninModel> _logger;

    public SigninModel(ILogger<SigninModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
