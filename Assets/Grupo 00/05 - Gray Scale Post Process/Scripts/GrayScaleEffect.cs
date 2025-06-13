using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]
public class GrayscaleEffect : MonoBehaviour
{
    [SerializeField] private Material grayscaleMaterial;
    [SerializeField] private Slider intensitySlider;

    private void Start()
    {
        if (intensitySlider != null)
            intensitySlider.onValueChanged.AddListener(val => grayscaleMaterial.SetFloat("_intensity", val));
    }

    private void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (grayscaleMaterial != null)
            Graphics.Blit(src, dest, grayscaleMaterial);
        else
            Graphics.Blit(src, dest);
    }
}
