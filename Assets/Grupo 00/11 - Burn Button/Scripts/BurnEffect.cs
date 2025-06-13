using UnityEngine;
using UnityEngine.UI;

public class BurnEffect : MonoBehaviour
{
    [SerializeField] private Material burnMaterial;
    [SerializeField] private Slider burnSlider;

    private void Start()
    {
        if (burnSlider != null && burnMaterial != null)
        {
            burnSlider.onValueChanged.AddListener(val =>
            {
                burnMaterial.SetFloat("_BurnStart", val);
                burnMaterial.SetFloat("_BurnStrength", val);
            });
        }
    }
}
