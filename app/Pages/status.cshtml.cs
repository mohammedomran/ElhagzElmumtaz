using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class StatusModel : PageModel
{
    private readonly ILogger<StatusModel> _logger;

    public StatusModel(ILogger<StatusModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
