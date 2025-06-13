using UnityEngine;
using UnityEngine.UI;

public class ProjectorManager : MonoBehaviour
{
    [Header("Materials")]
    public Material spinningMaterial;

    [Header("Sliders")]
    public Slider speedSlider;
    public Button changeDirButton;

    private float currentDirection = 1f;

    void Start()
    {
        speedSlider.onValueChanged.AddListener(OnSpeedChanged);
        changeDirButton.onClick.AddListener(ToggleDirection);

        UpdateDirection();
    }

    void OnSpeedChanged(float value)
    {
        spinningMaterial.SetFloat("_RotationSpeed", value);
    }

    void ToggleDirection()
    {
        currentDirection *= -1f;
        UpdateDirection();
    }

    void UpdateDirection()
    {
        spinningMaterial.SetFloat("_Direction", currentDirection);
    }
}

