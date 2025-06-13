using UnityEngine;
using UnityEngine.UI;

public class LensDistortionEffect : MonoBehaviour
{
    [SerializeField] private Material lensDistortionMaterial;
    [SerializeField] private Slider distortSlider;

    private void Start()
    {
        if (distortSlider != null && lensDistortionMaterial != null)
            distortSlider.onValueChanged.AddListener(val => lensDistortionMaterial.SetFloat("_Distort", val));
    }
}
