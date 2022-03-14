using UnrealBuildTool;

public class MidtermAssignmentTarget : TargetRules
{
	public MidtermAssignmentTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
		ExtraModuleNames.Add("MidtermAssignment");
	}
}
