using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class PixelEffect : MonoBehaviour
{
    [SerializeField] private Material pixelMaterial;
    [SerializeField] private Slider resolutionSlider;

    private void Start()
    {
        if (resolutionSlider != null)
            resolutionSlider.onValueChanged.AddListener(val => pixelMaterial.SetFloat("_Resolution", val));
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (pixelMaterial != null)
            Graphics.Blit(src, dest, pixelMaterial);
        else
            Graphics.Blit(src, dest);
    }
}

