using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class SignupModel : PageModel
{
    private readonly ILogger<SignupModel> _logger;

    public SignupModel(ILogger<SignupModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
