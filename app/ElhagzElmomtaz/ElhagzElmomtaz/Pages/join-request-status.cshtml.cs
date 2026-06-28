using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class JoinRequestStatusModel : PageModel
{
    private readonly ILogger<JoinRequestStatusModel> _logger;

    public JoinRequestStatusModel(ILogger<JoinRequestStatusModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
