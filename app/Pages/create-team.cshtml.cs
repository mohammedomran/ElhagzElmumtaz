using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class CreateTeamModel : PageModel
{
    private readonly ILogger<CreateTeamModel> _logger;

    public CreateTeamModel(ILogger<CreateTeamModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
