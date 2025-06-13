using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class VignetteEffect : MonoBehaviour
{
    [SerializeField] private Material vignetteMaterial;
    [SerializeField] private Slider powerSlider;
    [SerializeField] private Slider hardnessSlider;
    [SerializeField] private Slider scaleSlider;

    private void Start()
    {
        if (powerSlider != null)
            powerSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskPower", val));

        if (hardnessSlider != null)
            hardnessSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskHardness", val));

        if (scaleSlider != null)
            scaleSlider.onValueChanged.AddListener(val => vignetteMaterial.SetFloat("_MaskScale", val));
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (vignetteMaterial != null)
            Graphics.Blit(src, dest, vignetteMaterial);
        else
            Graphics.Blit(src, dest);
    }
}
