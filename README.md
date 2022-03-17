# dan.herbert.io Blog Code

All of the code for my personal blog.

## Important Maintenance Notes

*  `layouts/partials/footer.html` has been copied/overwritten from the PaperMod theme because it doesn't allow the modifications I want without completely replacing it. It is important to check this file for updates when syncing the submodule.
*  `layouts/_default/_markup/render-image.html` has custom image resizing code and while it's technically a fork of the PaperMod I've made enough changes to it that I consider it an entirely unique renderer that doesn't need manual syncing with PaperMod.
*  `layouts/_default/single.amp.html` is an entirely custom template for Amp-supported output. It borrows heavily from parts of the PaperMod theme and unfortunately couldn't just reference that theme's partials because it has too many things that are disallowed by Amp.
