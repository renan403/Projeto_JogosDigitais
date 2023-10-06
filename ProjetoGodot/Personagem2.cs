using Godot;
using System;
using System.Text;
using System.Threading;

public partial class Personagem2 : CharacterBody2D
{
	public const float Speed = 350.0f;
	public const float JumpVelocity = -700.0f;
	public Vector2 direction;
	public string animation;
	public AnimationPlayer animator;
	public Sprite2D sprite;
	public int con = 0; 

	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
	

	public override void _Ready()
	{
		animator = GetNode<AnimationPlayer>("AnimationPlayer");
		sprite = GetNode<Sprite2D>("Sprite2D");
		
	}

	public override void _PhysicsProcess(double delta)
	{
		if(con == 0)
		{
            SetAnimation("Idle");
            Thread.Sleep(2000);
			con = 1;
        }
        

        Vector2 velocity = Velocity;

		if (!IsOnFloor())
			velocity.Y += gravity * (float)delta;                  
			

		if (Input.IsActionJustPressed("ui_up") && IsOnFloor())		
			velocity.Y = JumpVelocity; 


		direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		
		if (direction != Vector2.Zero)
		{          
			velocity.X = direction.X * Speed;		
			sprite.FlipH = direction.X < 0;
		}	
		else
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
		
		if (velocity.X == 0 && IsOnFloor()) 
			SetAnimation("Stand");		
		else if (velocity.X != 0 && IsOnFloor())
			SetAnimation("Run");
		else if (!IsOnFloor())		
			SetAnimation("Jump");

		if (Input.IsActionJustPressed("ui_attack"))
			SetAnimation("Guard");
		Velocity = velocity;
		MoveAndSlide();
		
	}

	public void SetAnimation(string anim)
	{
		GD.Print(anim);
		if (animation != anim)
		{
			animation = anim;
			animator.Play(animation);
		}
	}
}
