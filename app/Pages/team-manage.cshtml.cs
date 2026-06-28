using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class TeamManageModel : PageModel
{
    private readonly ILogger<TeamManageModel> _logger;

    public TeamManageModel(ILogger<TeamManageModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
