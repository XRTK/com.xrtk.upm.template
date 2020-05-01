// Copyright (c) XRTK. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

namespace XRTK.Definitions.Platforms
{
    /// <summary>
    /// Used by the XRTK to signal that the feature is available on the PlatformName platform.
    /// </summary>
    public class PlatformNamePlatform : BasePlatform
    {
        /// <inheritdoc />
        public override bool IsAvailable
        {
            get
            {
                return false;
            }
        }

        ///// <inheritdoc />
        //public override bool IsBuildTargetAvailable
        //{
        //    get
        //    {
        //        return false;
        //    }
        //}
    }
}